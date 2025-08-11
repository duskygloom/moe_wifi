import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:moe_wifi/core/errors.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/session.dart';

class Api {
  static const baseURL = 'http://122.252.242.93';

  static const endpoints = {
    'login': '$baseURL/userportal/newlogin.do',
    'logout': '$baseURL/userportal/logout.do',
    'home': '$baseURL/userportal/home.do',
  };

  static const String useragent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0';

  const Api(this.config);

  final ConfigStorage config;

  static Api of(BuildContext context, [bool listen = false]) {
    return Api(ConfigStorage.of(context, listen));
  }

  Future<http.Response> request({
    required String method,
    required String url,
    bool sendCookies = true,
    bool followRedirects = false,
    Map<String, dynamic>? query,
  }) async {
    final Uri uri;
    if (query == null) {
      uri = Uri.parse(url);
    } else {
      uri = Uri.parse(url).replace(queryParameters: query);
    }
    final http.Request request;
    if (sendCookies) {
      request =
          http.Request(method, uri)
            ..followRedirects = followRedirects
            ..headers['cookie'] = config.cookie
            ..headers['user-agent'] = useragent;
    } else {
      request =
          http.Request(method, uri)
            ..followRedirects = followRedirects
            ..headers['user-agent'] = useragent;
    }

    final stream = await request.send().onError((error, trace) {
      if (error is http.ClientException) {
        throw KnownException('Not connected to network.');
      } else {
        throw KnownException(unhandledExceptionMessage);
      }
    });
    return http.Response.fromStream(stream);
  }

  Future<String> fetchAuthUrl(String route) async {
    final response = await request(
      method: 'GET',
      url: route,
      followRedirects: true,
    );
    final soup = html.parse(response.body);
    for (final tag in soup.getElementsByTagName('meta')) {
      final attributes = tag.attributes;
      if (attributes['http-equiv'] == 'Refresh') {
        const prefix = '1;URL=';
        final content = attributes['content'] ?? '';
        if (content.startsWith(prefix)) {
          final url = content.substring(prefix.length);
          config.authUrl = url;
          return url;
        }
      }
    }
    // not found
    throw KnownException('Failed to fetch auth URL from route: $route');
  }

  Future<void> refreshCookie(String route) async {
    final url = await fetchAuthUrl(route);
    final response = await request(method: 'GET', url: url, sendCookies: false);
    final String cookie = response.headers['set-cookie'] ?? '';
    config.cookie = cookie.split(';')[0];
  }

  Future<String> login(String phone, String password) async {
    final response = await request(
      method: 'POST',
      url: endpoints['login'] ?? '',
      query: {
        'username': phone,
        'password': password,
        'phone': '0',
        'type': '2',
        'jsonresponse': '1',
        'checkbox': 'check',
      },
    );
    final json = jsonDecode(response.body);
    final errorMessage = json['errorMessage'];
    if (errorMessage == null) {
      return json['errorKey'] ?? 'No error message.';
    } else if (json['errorKey'] == 'success') {
      return 'Successfully connected.';
    }
    return errorMessage.toString().endsWith('.')
        ? errorMessage.toString()
        : '$errorMessage.';
  }

  Future<void> logout() async {
    await request(method: 'POST', url: endpoints['logout'] ?? '');
  }

  Future<List<Session>> getSessions(String phone, String password) async {
    await request(
      method: 'POST',
      url: endpoints['login'] ?? '',
      query: {
        'generatePassword': 'true',
        'phone': '0',
        'type': '1',
        'username': phone,
        'password': password,
        'submit': 'continue',
      },
    );
    final response = await request(
      method: 'GET',
      url: endpoints['home'] ?? '',
      query: {'from': 'Home'},
    );
    final doc = html.parse(response.body);
    final table = doc.querySelector('table#row');
    List<Session> sessions = [];
    if (table == null) {
      if (doc.querySelector('head title')?.innerHtml == 'Enable') {
        throw KnownException('Session expired.');
      }
      return sessions;
    } else {
      for (final row in table.querySelectorAll('tbody tr')) {
        sessions.add(Session.fromRowElement(row));
      }
    }
    return sessions;
  }

  Future<void> terminateSession(int sessNumber) async {
    await request(
      method: 'GET',
      url: endpoints['logout'] ?? '',
      query: {'from': 'curses', 'sesno': sessNumber.toString()},
    );
  }
}
