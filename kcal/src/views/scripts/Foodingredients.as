package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Foodingredients extends Table
	{
		//current record data
		[Bindable]
		public var id:int;
		[Bindable]
		public var fkfoodname:int;
		[Bindable]
		public var ingredient:String;
		[Bindable]
		public var unitname:String;
		
		private var _unitkcal:String;
		private var _fquantity:String;

		[Bindable]
		public var fkcalsumm:String;
		
		public function Foodingredients(conn:SQLConnection)
		{
			super(conn);
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS FOODINGREDIENTS (id INTEGER PRIMARY KEY AUTOINCREMENT, fkfoodname INTEGER, ingredient TEXT, unitkcal DECIMAL(5, 2), fquantity DECIMAL(5, 2), fkcalsumm DECIMAL(5, 2))";
			stat.execute();
		}
		
		[Bindable]
		public function get unitkcal():String
		{
			return _unitkcal;
		}
		
		public function set unitkcal(value:String):void
		{
			_unitkcal = value;
			updateSumm();
		}
		
		[Bindable]
		public function get fquantity():String
		{
			return _fquantity;
		}
		
		public function set fquantity(value:String):void
		{
			_fquantity = value;
			updateSumm();
		}
		
		private function updateSumm():void{
			fkcalsumm = String(Number(_fquantity)*Number(_unitkcal));	
		}
		
		
		public function selectItems(curentfood:Food, rowsResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "SELECT * FROM FOODINGREDIENTS WHERE FKFOODNAME = " + curentfood.id + " ORDER BY id";
			stat.execute(-1, rowsResponder);
		}
		
		public function newItem(curentfood:Food):void
		{
			id = -1;
			fkfoodname = curentfood.id;
			ingredient = "";
			unitkcal = "";
			fquantity = "";
			fkcalsumm = "";
			status.operation = "New";
		}
		
		public function editItem(item:Object):void
		{
			id = item.id;
			fkfoodname = item.fkfoodname;
			ingredient = item.ingredient;
			unitkcal = item.unitkcal;
			fquantity = item.fquantity;
			fkcalsumm = item.fkcalsumm;
			status.operation = "Edit";
		}
		
		public function saveItem():void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@fkfoodname"] = fkfoodname;
			stat.parameters["@ingredient"] = ingredient;
			stat.parameters["@unitkcal"] = unitkcal;
			stat.parameters["@fquantity"] = fquantity;
			stat.parameters["@fkcalsumm"] = fkcalsumm;
			if(id == -1){
				stat.text = "INSERT INTO FOODINGREDIENTS (fkfoodname, ingredient, unitkcal, fquantity, fkcalsumm) VALUES (@fkfoodname, @ingredient, @unitkcal, @fquantity, @fkcalsumm)";
			}else{
				stat.parameters["@id_foodingredient"] = id;
				stat.text = "UPDATE FOODINGREDIENTS SET fkfoodname=@fkfoodname, ingredient=@ingredient, unitkcal=@unitkcal, fquantity=@fquantity, fkcalsumm=@fkcalsumm WHERE id=@id_foodingredient";
			}
			stat.execute();
		}
		
		public function deleteItem(item:Object):void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@id_foodingredient"] = item.id;
			stat.text = "DELETE FROM FOODINGREDIENTS WHERE id=@id_foodingredient";
			stat.execute();	
		}
		
	}
}