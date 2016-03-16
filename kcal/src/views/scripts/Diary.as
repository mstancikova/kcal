package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;
	import views.scripts.Functions;

	public class Diary extends Table
	{
		
		
		public function Diary(conn:SQLConnection)
		{
			super(conn);
			
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS DIARY (id INTEGER PRIMARY KEY AUTOINCREMENT, ddate TEXT, dwhat TEXT, iunitkcal DECIMAL(5, 2), dquantity TEXT, dsumm DECIMAL(5, 2), dnote TEXT)";
			stat.execute();
		}
		
		public function selectItems(rowsResponder:Responder, summResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "SELECT * FROM DIARY WHERE ddate='"+Functions.getDateFormated(new Date())+"' ORDER BY id";
			stat.execute( -1, rowsResponder);
			
			var stat1:SQLStatement = new SQLStatement();
			stat1.sqlConnection = connection;
			stat1.text = "SELECT sum(dsumm) AS somma FROM DIARY WHERE ddate='"+Functions.getDateFormated(new Date())+"'";
			stat1.execute( -1, summResponder);
		}
		
		public function Create(what:Object, createResponder:Responder):void {
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "INSERT INTO DIARY (ddate, dwhat, iunitkcal, dquantity, dsumm, dnote) VALUES (@ddate, @dwhat, @iunitkcal, @dquantity, @dsumm, @dnote)";
			stat.execute(-1, createResponder);
		}
		
		public function Update(what:Object, updatedResponder:Responder):void {
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "UPDATE DIARY SET ddate=@ddate, dwhat=@dwhat, iunitkcal=@iunitkcal, dquantity=@dquantity, dsumm=@dsumm, dnote=@dnote WHERE id=@id_diary";
			stat.execute(-1, updatedResponder);
		}
		
		public function Delete(what:Object):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "DELETE FROM DIARY WHERE id=@id_diary";
			stat.execute();
		}
		
	}
}