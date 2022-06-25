import 'package:hive/hive.dart';

import '../common/string_const.dart';
import '../data/model/kondisi/ref_nama_pengisi_model.dart';
import '../data/model/references_dimensi_model.dart';
import '../data/model/references_kondisi_model.dart';

var boxHive = Hive.box('UserBox');
var boxReferenceDimensi = Hive.box<ReferencesDimensi>(StringConst.boxReferenceDimensi);

class RefDimensi {
  static ReferencesDimensi? getReferenceDimensi() {
    return boxReferenceDimensi.get(StringConst.keyReferenceDimensi);
  }

  static Future setReferenceDimensi(ReferencesDimensi references) async {
    await boxReferenceDimensi.put(
      StringConst.keyReferenceDimensi,
      references,
    );
  }
}

var boxReferenceKondisi = Hive.box<ReferencesKondisi>(StringConst.boxReferenceKondisi);
var boxReferenceKondisiNamaPengisi = Hive.box<ReferencesKondisiNamaPengisi>(StringConst.boxReferenceKondisiNamaPengisi);

class RefKondisi {
  static ReferencesKondisi? getReferenceKondisi() {
    return boxReferenceKondisi.get(StringConst.keyReferenceKondisi);
  }

  static Future setReferenceKondisi(ReferencesKondisi references) async {
    await boxReferenceKondisi.put(
      StringConst.keyReferenceKondisi,
      references,
    );
  }
  static ReferencesKondisiNamaPengisi? getReferenceKondisiNamaPengisi() {
    return boxReferenceKondisiNamaPengisi.get(StringConst.keyReferenceKondisiNamaPengisi);
  }

  static Future setReferenceKondisiNamaPengisi(ReferencesKondisiNamaPengisi references) async {
    await boxReferenceKondisiNamaPengisi.put(
      StringConst.keyReferenceKondisiNamaPengisi,
      references,
    );
  }
}

dynamic hiveGet(dynamic key, {dynamic defaultValue}) {
  if (defaultValue == null) return boxHive.get(key);
  return boxHive.get(key, defaultValue: defaultValue);
}

dynamic hivePut(String key, dynamic value) {
  boxHive.put(key, value);
}

Future hiveClear() async {
  await boxHive.clear();
  await boxReferenceDimensi.clear();
  await boxReferenceKondisi.clear();
  await boxReferenceKondisiNamaPengisi.clear();
}
