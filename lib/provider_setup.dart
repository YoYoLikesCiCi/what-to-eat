import 'package:provider/provider.dart';
import 'package:what_to_eat/models/Foods.dart';

import 'models/ProviderChat.dart';

import 'package:provider/single_child_widget.dart';


List<SingleChildStatelessWidget> providers =[
    
    
    ChangeNotifierProvider<ChatModel>(
        create: (_) => ChatModel(),
    ),
    
    ChangeNotifierProvider<FoodModel>(
        create: (_) => FoodModel(),
    )
];