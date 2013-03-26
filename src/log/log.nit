module log


#Apres avoir instancier le Log , il faut l'initialiser. un Fichier Log.txt est alors creer
#Se module comprend deux fonctions
#	log.error(id:Int,message:String)
#	log.debug(id:Int,tag:String,message:String)


in "C header" `{
	#include<stdio.h>
	#include<time.h>
	#include<string.h>
`}

# Class Log
class Log 

	#permet de cree un fichier Log vide
	fun initialise `{
		FILE * file = fopen("log_file.log","w");
		if (file == NULL){
			printf("IMPOSSIBLE D'OUVRIR LE FICHIER LOG");
			exit(1);
		}
		fclose (file);
	`}

	#function qui ajoute un message d'erreur au fichier log
	fun error(id:Int,message:String) :Int is extern import String::to_cstring `{
		FILE * file = fopen("log_file.log","a");
		if (file == NULL){
			printf("IMPOSSIBLE D'OUVRIR LE FICHIER LOG");
			exit(1);
		}
		int c_id = id;
		char * c_message = String_to_cstring(message);
		time_t date = time(NULL);
		char * s = ctime(&date);
		s[24]= '\t';	
		fprintf(file,"%s",s);
		fprintf(file,"%d\t",c_id);
		fprintf(file,"ERROR\t");
		fprintf(file,"%s\n",c_message);
		fclose (file);
	`}
	
	#function qui ajoute un message d'état au fichier log
	fun debug(id:Int,tag:String,message:String) :Int is extern import String::to_cstring `{ 
		FILE * file =fopen("log_file.log","a");
		if(file == NULL){
			printf("IMPOSSIBLE D'OUVRIR LE FICHIER LOG");
			exit(1);
		}
		int c_id = id;
		char * c_tag = String_to_cstring(tag);	
		char * c_message = String_to_cstring(message);
		time_t date = time(NULL);
		char * s = ctime(&date);
		s[24]= '\t';	
		fprintf(file,"%s",s);
		fprintf(file,"%d\t",c_id);
		fprintf(file,"%s\t",c_tag);
		fprintf(file,"%s\n",c_message);
		fclose(file);
	`}
end
	






