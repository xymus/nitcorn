module sqlite3

in "C header" `{
	#include "sqlite3.h"
	struct Data{
		sqlite3 *ppDb;
		sqlite3_stmt * stmt;
	};

`}
extern Sqlite3

	new is extern `{
		struct Data* data = malloc(sizeof(data));
		return data;
	`}

	fun destroy do 
		close
	end

	fun open(filename : String) is extern import String::to_cstring`{	
		sqlite3_open(String_to_cstring(filename), &((struct Data*)recv)->ppDb);
	`}

	fun close is extern `{
		sqlite3_close(((struct Data*) recv)->ppDb);
		free(recv);
	`}

	fun exec(sql : String): Int is extern import String::to_cstring `{
		struct Data * data = recv;
		return sqlite3_exec(data->ppDb, String_to_cstring(sql), 0, 0, 0);
	`}

	fun prepare(sql : String) is extern import String::to_cstring `{
		struct Data * data = recv;
		int ret = sqlite3_prepare_v2(data->ppDb, String_to_cstring(sql), -1, &(data->stmt), 0);
	`}

	fun step: Int is extern `{
		return sqlite3_step(((struct Data*)recv)->stmt);
	`}

	fun column_name(i: Int) : String is extern import String::from_cstring `{
		const char * name = (sqlite3_column_name(((struct Data*)recv)->stmt, i));
		if(name == NULL){
			name = "";
		}
		char * ret = (char *) name;
		return new_String_from_cstring(ret);
	`}

	fun column_bytes(i: Int) : Int is extern `{
		return sqlite3_column_bytes(((struct Data*)recv)->stmt, i);
	`}

	fun column_double(i: Int) : Float is extern `{
		return sqlite3_column_double(((struct Data*)recv)->stmt, i);
	`}

	fun column_int(i: Int) : Int is extern `{
		return sqlite3_column_int(((struct Data*)recv)->stmt, i);
	`}

	fun column_text(i: Int) : String is extern import String::from_cstring `{
		char * ret = (char *) sqlite3_column_text(((struct Data*)recv)->stmt, i);
		if( ret == NULL ){
			ret = "";
		}
		return new_String_from_cstring(ret);
	`}

	fun column_type(i: Int) : Int is extern `{
		return sqlite3_column_type(((struct Data*)recv)->stmt, i);
	`}

	#	fun column_blob(i : Int) : String is extern `{
	#		TODO
	#	`}

	fun column_count: Int is extern `{
		return sqlite3_column_count(((struct Data*)recv)->stmt);
	`}

	fun last_insert_rowid: Int is extern `{
		return sqlite3_last_insert_rowid(((struct Data*)recv)->ppDb);
	`}


	fun get_error : Int is extern import String::from_cstring `{
		return sqlite3_errcode(((struct Data*)recv)->ppDb);
	`}

	fun get_error_str : String is extern import String::from_cstring `{
		char * err =(char *) sqlite3_errmsg(((struct Data*)recv)->ppDb);
		if(err == NULL){
			err = "";
		}
		return new_String_from_cstring(err);
	`}

end

