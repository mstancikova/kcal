package views.scripts
{

	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.events.SQLErrorEvent;
	import flash.filesystem.File;

	public class Model extends Object
	{	
		private static var _instance:Model;
		private var connection:SQLConnection;
		
		public var categoryStatus:Object = new Object();
		public var categoryColumn:Object = new Object();
		public var ingredientStatus:Object = new Object();
		public var ingredientColumn:Object = new Object();
		public var unitStatus:Object = new Object();
		public var unitColumn:Object = new Object();
		public var diaryStatus:Object = new Object();
		public var diaryColumn:Object = new Object();
		
		
		private var diary:Diary;
		private var units:Units;
		private var categories:Categories;
		private var ingredients:Ingredients;
				
		public function Model()
		{
			if(_instance){
				throw new Error("Singleton... use getInstance()");
			} 
			_instance = this;
			init();
		}
		
		public static function getInstance():Model{
			if(!_instance){
				new Model();
			} 
			return _instance;
		}		
		
		private function init():void{		
			var dbFile:File = File.applicationDirectory.resolvePath("db/kcal_01.db");
			var dbWorkFile:File = File.documentsDirectory.resolvePath("kcal_01.db");
			connection = new SQLConnection();
			connection.open(dbFile, SQLMode.CREATE);
			connection.addEventListener(SQLErrorEvent.ERROR, onError);
			
			//open tables
			diary = new Diary(connection);
			units = new Units(connection);
			categories = new Categories(connection);
			ingredients = new Ingredients(connection);
		}
		protected function onError(event:SQLErrorEvent):void{
			trace(event.text);
		}

		
		// tables
		public function getDiary() : Diary
		{
			return diary;
		}
		public function getUnits() : Units
		{
			return units;
		}
		public function getCategories() : Categories
		{
			return categories;
		}
		public function getIngredients() : Ingredients
		{
			return ingredients;
		}
		
		
		
		
		
	}
}