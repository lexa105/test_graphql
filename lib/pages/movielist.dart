import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlObject {
  static HttpLink httpLink = HttpLink('https://trailers-status.hasura.app/v1/graphql',
  defaultHeaders: {
    'x-hasura-admin-secret' : 'yGhNTYOzOZJyhElsP4uj690wY32ZQ3KIcw6xlHK3l5155uEPJhC5druHSV2Ex5jf'
  });

 /* static AuthLink authLink = AuthLink(
      headerKey: 'x-hasura-admin-secret',
      getToken: () async =>
        'yGhNTYOzOZJyhElsP4uj690wY32ZQ3KIcw6xlHK3l5155uEPJhC5druHSV2Ex5jf');

  */

  //Client graphql
  //ValueNotifier take an argument GraphQLClient which will be 
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()), //Store to keep cache
      link: httpLink
    )
  );
}

GraphQlObject graphQlObject = GraphQlObject();


String fetchQuery() {
  return(
    '''
    query MyQuery {
  movie_table {
    id
    movie_name
    source
    duration
    campaign
  }
}
    '''
  );
}
