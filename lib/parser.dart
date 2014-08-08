part of dabl_generator;


Future<Database> getDatabaseSchema(DABLDDO ddo) {
	Completer c = new Completer();
	if(ddo is DBMySQL) {
		MysqlSchemaParser parser = new MysqlSchemaParser(ddo);
		Database db = new Database(ddo.getDBName());
		MysqlPlatform platform = new MysqlPlatform(ddo);
		platform.setDefaultTableEngine('InnoDB');
		db.setPlatform(platform);

		parser.parse(db).then((_) {
			db.doFinalInitialization();
			c.complete(db);
		});
	} else {
		throw new UnsupportedError('Connection type not recognized');
	}

	return c.future;
}
