// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_mo2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestMo2 _$TestMo2FromJson(Map<String, dynamic> json) {
  return TestMo2(
    json['code'] as int,
    json['method'] as String,
    json['requestPrams'] as String,
  );
}

Map<String, dynamic> _$TestMo2ToJson(TestMo2 instance) => <String, dynamic>{
      'code': instance.code,
      'method': instance.method,
      'requestPrams': instance.requestPrams,
    };
