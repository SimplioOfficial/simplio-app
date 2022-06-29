import 'dart:convert';

mixin JwtMixin {
  Map<String, dynamic> parseJwt(String token) {
    final List<String> sections = token.split(".");

    if (sections.length < 3) {
      throw Exception("JWT token has invalid format");
    }

    final String payload = sections[1];

    try {
      final decodedPayload = _decode(payload);
      final decodedJson = json.decode(decodedPayload);

      return decodedJson;
    } catch (e) {
      throw Exception("Jwt body could not be decoded.");
    }
  }

  String _decode(String base64String) {
    final normalized = base64Url.normalize(base64String);
    return utf8.decode(base64Url.decode(normalized));
  }
}
