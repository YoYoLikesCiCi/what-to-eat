import 'package:provider/provider.dart';

import 'functions/ProviderChat.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildStatelessWidget> providers =[
    
    
    ChangeNotifierProvider<ChatModel>(
        create: (_) => ChatModel(),
    )
];