import 'package:BackendAPI/api.dart';

String localize(ComponentWarrantySource source) {
  switch (source) {
    case ComponentWarrantySource.COMPANY_WARRANTY:
      return "Firemná záruka";
    case ComponentWarrantySource.INVESTMENT_CONTRACT:
      return "Investičná zmluva";
    case ComponentWarrantySource.NAN:
      return "Žiadna záruka";
  }
  return "Neznámy zdroj záruky";
}
