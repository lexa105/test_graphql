import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'services/graphql.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQlObject.client,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Menu(),
        ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Query(
        options: QueryOptions(
          document: gql(fetchQuery()), 
          pollInterval: Duration(seconds: 4),
          ), 
        builder: (QueryResult result, {Refetch? refetch, FetchMore? fetchMore}) {

          if(result.isLoading) {
            return Center(child: Text('Loading...', 
            style: TextStyle(color: Colors.amber),),
            );
          }

          if(result.hasException) {
            return Center(child: Text('Exception !!', 
            style: TextStyle(color: Colors.amber),),
            );
          }

          List movies = result.data?["Movies"];

          int len = movies.length;
          return RefreshIndicator(
            onRefresh: () async {
            await refetch?.call();
          },
          child: movies.length == 0 ?
            ListView(
              padding: EdgeInsets.only(left: 15, right: 15),
              children: [
                Container(
                  padding: EdgeInsets.only(top: 300),
                  child: Center(
                    child: Text('No movies yet :(', style: TextStyle(color: Colors.amber),),
                  ),
                )
              ],
            )
            : Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Center(
                child: Text(movies.toString())
              )
              ),
            );
      
        }
      ),
    );
  }
}
