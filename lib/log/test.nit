import log

var log : Log = new Log
log.initialise

log.error(0, "Error lors du chargement".to_cstring)
log.debug(1, "GET".to_cstring ,"Succes".to_cstring)



