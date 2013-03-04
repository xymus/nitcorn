module log


#Apres avoir instancier le Log , il faut l'initialiser. un Fichier Log.txt est alors creer
#Se module comprend deux fonctions
#error(id:Int,message:NativeString)
#debug(id:Int,tag:NativeString,message:NativeString)


in "C header" `{
	#include<stdio.h>
	#include<time.h>
`}

# Class Log
class Log 

	#permet de cree un fichier Log vide
	fun initialise `{
		FILE * file = fopen("log.txt","w");
		if (file == NULL){
			printf("IMPOSSIBLE D'OUVRIR LE FICHIER LOG");
			exit(1);
		}
		fclose (file);
	`}

	#function qui ajoute un message d'erreur au fichier log
	fun error(id:Int,message:NativeString)  `{
		FILE * file = fopen("log.txt","a");
		if (file == NULL){
			printf("IMPOSSIBLE D'OUVRIR LE FICHIER LOG");
			exit(1);
		}
		time_t date = time(NULL);
		char * s = ctime(&date);
		s[24]= '\t';	
		fprintf(file,"%s",s);
		fprintf(file,"%d\t",id);
		fprintf(file,"ERROR\t");
		fprintf(file,"%s\n",message);
		fclose (file);
	`}
	
	#function qui ajoute un message d'état au fichier log
	fun debug(id:Int,tag:NativeString,message:NativeString) `{ 
		FILE * file =fopen("log.txt","a");
		if(file == NULL){
			printf("IMPOSSIBLE D'OUVRIR LE FICHIER LOG");
			exit(1);
		}
		time_t date = time(NULL);
		char * s = ctime(&date);
		s[24]= '\t';	
		fprintf(file,"%s",s);
		fprintf(file,"%d\t",id);
		fprintf(file,"%s\t", tag);
		fprintf(file,"%s\n",message);
		fclose(file);
	`}
end
	






