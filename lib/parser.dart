part of dabl_generator;


Future<Database> getDatabaseSchema(DABLDDO ddo) {
	if(ddo is DBMySQL) {
		MysqlSchemaParser parser = new MysqlSchemaParser(ddo);
		Database db = new Database(ddo.getDBName());
		MysqlPlatform platform = new MysqlPlatform(ddo);
		platform.setDefaultTableEngine('InnoDB');
		db.setPlatform(platform);

		return parser.parse(db).then((_) {
			db.doFinalInitialization();
			return db;
		});
	}
	return new Future.error('Connection type not recognized');


}
