/* file generated by nits for module sockets */



#include "sockets.nit.h"

#include <fcntl.h>

/*
C implementation of sockets::CommunicationSocket::connect

Imported methods signatures:
	char * String_to_cstring( String recv ) for string::String::to_cstring
*/
CommunicationSocket new_CommunicationSocket_connect_to___impl( String address, bigint port )
{
    struct addrinfo hints;
	struct addrinfo *result, *rp;
    int sfd, s;
    char *host;
    char *sport;
	CommunicationSocket sock;
	
    memset(&hints, 0, sizeof(struct addrinfo));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM; 
    hints.ai_flags = AI_PASSIVE;
    
    host = String_to_cstring( address );
    sport = calloc( 256, sizeof(char) ); 
    sprintf( sport, "%ld", port );
    
    if ( (s = getaddrinfo( host, sport, &hints, &result ) ) != 0 )
    {
        fprintf(stderr, "getaddrinfo failed with: %s\n", gai_strerror(s));
        exit(1);
    }
    
    /* iterate through possible addresses */
    for (rp = result; rp != NULL; rp = rp->ai_next)
    {
        sfd = socket(rp->ai_family, rp->ai_socktype,
                rp->ai_protocol);
                
        if (sfd == -1)
            continue;

        if (connect(sfd, rp->ai_addr, rp->ai_addrlen) != -1)
            break;                  /* Success */

        close(sfd);
    }
    

    if (rp == NULL) {               /* No address succeeded */
        fprintf(stderr, "Could not connect\n");
        return 0;
    }
    
    freeaddrinfo(result);
    
    /* store in a pointer and return to nit */
	sock = (CommunicationSocket)malloc( sizeof(int) );
	(*sock) = sfd;
	return sock;
}

/*
C implementation of sockets::CommunicationSocket::from_fd
CommunicationSocket new_CommunicationSocket_from_fd___impl( bigint fd )
{
	
}
*/

/*
C implementation of sockets::CommunicationSocket::error

Imported methods signatures:
	String new_String_from_cstring( char * str ) for string::String::from_cstring
*/
nullable_String CommunicationSocket_error___impl( CommunicationSocket recv )
{
	return String_as_nullable( new_String_from_cstring( strerror( errno ) ) );
}

/*
C implementation of sockets::CommunicationSocket::errno

Imported methods signatures:
	String new_String_from_cstring( char * str ) for string::String::from_cstring
*/
bigint CommunicationSocket_errno___impl( CommunicationSocket recv )
{
	return errno;
}
/*
C implementation of sockets::CommunicationSocket::close
*/
void CommunicationSocket_close___impl( CommunicationSocket recv )
{
	int fd = *recv;
	close( fd );
	free( recv );
}

/*
C implementation of sockets::CommunicationSocket::read

Imported methods signatures:
	String new_String_from_cstring( char * str ) for string::String::from_cstring
*/
#define BUF_LEN 1
nullable_String CommunicationSocket_read___impl( CommunicationSocket recv )
{
	int fd = *recv;
	char *buffer = calloc( BUF_LEN, sizeof(char) );
	int r_len;
	
	r_len = read( fd, buffer, BUF_LEN );
	
#ifdef DEBUG
	printf( "DEBUG: read %d bytes: %s\n", r_len, buffer );
#endif
	
	if ( r_len == 0 )
	{
        free( buffer );
		return null_String();
	}
	else if ( r_len < 0 )
	{
        /*fprintf(stderr, "Cannot read %s\n", strerror( r_len ) );*/
        free( buffer );
		return null_String();
	}
	else
		return String_as_nullable( new_String_from_cstring( buffer ) );
}

/*
C implementation of sockets::CommunicationSocket::write

Imported methods signatures:
	char * String_to_cstring( String recv ) for string::String::to_cstring
*/
void CommunicationSocket_write___impl( CommunicationSocket recv, String s )
{
	int fd = *recv;
	char *cs = String_to_cstring( s );
	int len = strlen( cs ) + 1;
	int written;
	
#ifdef DEBUG
	printf( "DEBUG: writing %s\n", cs );
#endif
	
	written = write( fd, cs, len );
	if ( written != len )
		fprintf( stderr, "Write failed with %s, len: %d != %d, when trying to write \"%s\"", strerror( errno ), len, written, cs );
}

/*
C implementation of sockets::ListeningSocket::bind

Imported methods signatures:
	char * String_to_cstring( String recv ) for string::String::to_cstring
*/
ListeningSocket new_ListeningSocket_bind_to___impl( String address, bigint port )
{
	struct addrinfo hints;
	struct addrinfo *result, *rp;
    int sfd, s;
    char *host;
    char *sport;
    int flags;
	CommunicationSocket sock;
	
    memset(&hints, 0, sizeof(struct addrinfo));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM; 
    hints.ai_flags = AI_PASSIVE;
    
    host = String_to_cstring( address );
    sport = calloc( 256, sizeof(char) ); 
    sprintf( sport, "%ld", port );
    
    if ( (s = getaddrinfo( host, sport, &hints, &result ) ) != 0 )
    {
        fprintf(stderr, "getaddrinfo failed with: %s\n", gai_strerror(s));
        return 0;
    }
    
    /* iterate through possible addresses */
    for (rp = result; rp != NULL; rp = rp->ai_next)
    {
        sfd = socket(rp->ai_family, rp->ai_socktype,
                rp->ai_protocol);
                
        if (sfd == -1)
            continue;

        if (bind(sfd, rp->ai_addr, rp->ai_addrlen) == 0)
            break;                  /* Success */

        close(sfd);
    }
    

    if (rp == NULL) {               /* No address succeeded */
        fprintf(stderr, "Could not connect\n");
        return 0;
    }
    
    freeaddrinfo(result);
    
    /* set as non-blocking */
    if (-1 == (flags = fcntl( sfd, F_GETFL, 0 )))
        flags = 0;
    fcntl( sfd, F_SETFL, flags | O_NONBLOCK );
    
    /* set as listen */
	listen( sfd, 1 );
    
    /* store in a pointer and return to nit */
	sock = (CommunicationSocket)malloc( sizeof(int) );
	(*sock) = sfd;
	return sock;
}

/*
C implementation of sockets::ListeningSocket::error

Imported methods signatures:
	String new_String_from_cstring( char * str ) for string::String::from_cstring
*/
nullable_String ListeningSocket_error___impl( ListeningSocket recv )
{
	return String_as_nullable( new_String_from_cstring( strerror( errno ) ) );
}

/*
C implementation of sockets::ListeningSocket::error

Imported methods signatures:
	String new_String_from_cstring( char * str ) for string::String::from_cstring
*/
bigint ListeningSocket_errno___impl( ListeningSocket recv )
{
	return errno;
}

/*
C implementation of sockets::ListeningSocket::close
*/
void ListeningSocket_close___impl( ListeningSocket recv )
{
	int fd = *recv;
	close( fd );
	free( recv );
}

/*
C implementation of sockets::ListeningSocket::accept

Imported methods signatures:
	CommunicationSocket new_CommunicationSocket_from_fd( bigint fd ) for sockets::CommunicationSocket::from_fd
*/
nullable_CommunicationSocket ListeningSocket_accept___impl( ListeningSocket recv )
{
	int fd = *recv;
	int nfd;
	
	nfd = accept( fd, NULL, NULL );
	if ( nfd > 0 )
	{
		/* store in a pointer and return to nit */
		CommunicationSocket s = (CommunicationSocket)malloc( sizeof(int) );
		(*s) = nfd;
		return CommunicationSocket_as_nullable( s );
	}
	else if ( nfd < 0 )
	{
	/*	fprintf( stderr, "Accept failed with %s", strerror( errno ) );*/
		return null_CommunicationSocket();
	}
	else
		return null_CommunicationSocket();
}

