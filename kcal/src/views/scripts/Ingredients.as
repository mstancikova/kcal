package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Ingredients extends Table
	{
		//current record data
		[Bindable]
		public var id:int;
		[Bindable]
		public var ingname:String;
		[Bindable]
		public var fkcatname:String;
		[Bindable]
		public var fkunitname:String;
		[Bindable]
		public var unitkcal:String;
		
		public function Ingredients(conn:SQLConnection)
		{
			super(conn);
			
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS INGREDIENT (id INTEGER PRIMARY KEY AUTOINCREMENT, ingname TEXT, fkcatname TEXT, fkunitname TEXT, unitkcal DECIMAL(5, 2))";
			stat.execute();
		}
		
		public function selectItems(rowsResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "SELECT * FROM INGREDIENT ORDER BY ingname";
			stat.execute(-1, rowsResponder);
		}
		
		public function selectByCategory(what:Object, rowsResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "SELECT * FROM INGREDIENT WHERE fkcatname=@catfilter ORDER BY ingname";
			stat.execute(-1, rowsResponder);
		}
		
		public function Create(what:Object, createResponder:Responder):void {
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "INSERT INTO INGREDIENT (ingname, fkcatname, fkunitname, unitkcal) VALUES (@ingname, @fkcatname, @fkunitname, @unitkcal)";
			stat.execute(-1, createResponder);
		}
		
		public function Update(what:Object, updatedResponder:Responder):void {
				var stat:SQLStatement = new SQLStatement();
				stat.sqlConnection = connection;
				for(var i:Object in what){
					stat.parameters[i] = what[i];
				}
				stat.text = "UPDATE INGREDIENT SET ingname=@ingname, fkcatname=@fkcatname, fkunitname=@fkunitname, unitkcal=@unitkcal WHERE id=@id_ingredient";
				stat.execute(-1, updatedResponder);
		}
		
		public function Delete(what:Object):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "DELETE FROM INGREDIENT WHERE id=@id_ingredient";
			stat.execute();
		}
	}
}