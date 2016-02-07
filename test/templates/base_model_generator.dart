import 'package:unittest/unittest.dart';
import 'package:dabl_generator/generator.dart';
import 'package:dabl/dbmanager.dart' as DBManager;
import 'package:ddo/drivers/ddo_mysql.dart';
import 'dart:async';

main() async {
	DBManager.addConnection('test', new DDOMySQL('127.0.0.1', 'redstone_test', 'redstone', 'password'));

	DefaultGenerator dg = new DefaultGenerator('test');
	await dg.initialize();
	test('generates model', (){

		Future<String> result = dg.getBaseModel('user');
		expect(result, completion(isNot(isEmpty)));
	});
}
