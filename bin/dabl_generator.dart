import 'package:args/args.dart';
import 'package:ddo/ddo.dart';
import 'package:dabl/dbmanager.dart';
import 'package:ddo/drivers/ddo_mysql.dart';
import '../lib/generator.dart';

void main(List<String> arguments) {
	final parser = new ArgParser()
	..addOption('type', abbr: 't', help: 'Database engine type', allowed: ['mysql'])
	..addOption('username', abbr: 'u', help: 'Username')
	..addOption('password', abbr: 'p', help: 'Password')
	..addOption('dbname', abbr: 'd', help: 'Database name')
	..addOption('host', abbr: 'h', help: 'Host name or address');
	ArgResults results = parser.parse(arguments);
	Driver driver;
	switch(results['type']) {
		case 'mysql':
			driver = new DDOMySQL(results['host'], results['dbname'], results['username'], results['password']);
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
   	dg.generateProjectFiles();
}
