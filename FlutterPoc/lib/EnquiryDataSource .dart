import 'package:flutter/material.dart';
class EnquiryDataSource extends DataTableSource {
//CentreData centreData;
//EnquiryDataSource(this.centreData);


  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('Date Cell')),
      DataCell(Text('Name Cell')),
      DataCell(Text('Status Cell')),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => true;

  @override
  // TODO: implement rowCount
  int get rowCount => 15;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}