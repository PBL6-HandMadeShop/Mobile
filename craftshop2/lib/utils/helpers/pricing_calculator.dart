class CSPRicingCalculator {
  static double calculateTotalPrice( double productPrice, String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double ShippingCost = getShippingCost(location);
    double totalPrice = productPrice + taxAmount + ShippingCost;
    return totalPrice;
  }
  //--- CalculateShippingCost
  static String calculateShippingCost(double productPrice, String location){
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }
  //--- calculate tax
  static String calculateTax(double productPrice, String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }
  //--- getTaxRateForLocation
  static double getTaxRateForLocation(String location){
      return 0.08;
  }
  static double getShippingCost(String location){
    return 5.00;
  }
}