import 'package:args/args.dart';
import 'package:ddo/ddo.dart';
import 'package:dabl/dbmanager.dart';
import 'package:ddo/drivers/ddo_mysql.dart';
import '../lib/generator.dart';
import 'dart:io';

void main(List<String> arguments) {
	final parser = new ArgParser()
	..addOption('type', abbr: 't', help: 'Database engine type', allowed: ['mysql'])
	..addOption('username', abbr: 'u', help: 'Username')
	..addOption('password', abbr: 'p', help: 'Password')
	..addOption('dbname', abbr: 'd', help: 'Database name')
	..addOption('server', abbr: 's', help: 'Server name or address')
	..addFlag('help', abbr: 'h', help: 'Show this help', defaultsTo: false, negatable: false);
	ArgResults results;
	try {
		results = parser.parse(arguments);
	} catch (e) {
		print('There was a problem with the options:');
		print((e as FormatException).message);
	}
	if(results == null || results['help'] || results['server'] == null || results['dbname'] == null || results['username'] == null || results['password'] == null ) {
		print(parser.getUsage());
		exit(0);
	}
	Driver driver;
	switch(results['type']) {
		case 'mysql':
			driver = new DDOMySQL(results['server'], results['dbname'], results['username'], results['password']);
			break;
		default:
			break;
	}
	addConnection('generator', driver);
	DefaultGenerator dg = new DefaultGenerator('generator');
   	dg.setOptions({
   		'project_path': 'project/',
   		'model_path': 'models/',
   		'base_model_path': 'models/base/'
   	});
   	dg.generateProjectFiles().then((_){
   		print('Files saved to project/');
   		exit(0);
   	});
}
