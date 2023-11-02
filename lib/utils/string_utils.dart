String customOrderSortKey(String input) {
  // Custom order for several European characters
  const lowercaseOrder = 'aáàäåæbcčdďeéěèëfghchiíìïjklmnňoóòöøpqrřsštťuúůùüvwxyýÿzž';
  const uppercaseOrder = 'AÁÀÄÅÆBCČDĎEÉĚÈËFGHCHIÍÌÏJKLMNŇOÓÒÖØPQRŘSŠTŤUÚŮÙÜVWXYÝŸZŽ';

  // Merge lowercase and uppercase orderings letter by letter
  var mergedOrder = StringBuffer();
  for (var i = 0; i < lowercaseOrder.length; i++) {
    mergedOrder.write(lowercaseOrder[i]);
    if (i < uppercaseOrder.length) {
      mergedOrder.write(uppercaseOrder[i]);
    }
  }
  final order = mergedOrder.toString();

  final buffer = StringBuffer();
  for (var char in input.split('')) {
    final index = order.indexOf(char);
    if (index != -1) {
      buffer.write(index.toString().padLeft(4, '0'));
    } else {
      buffer.write(char.codeUnitAt(0).toString().padLeft(4, '0'));
    }
  }
  return buffer.toString();
}
