import 'package:flutter/material.dart';
import 'package:flutter_amazon/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 144, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, size: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                style: TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2, left: 5),
            child: Icon(Icons.arrow_drop_down_outlined, size: 18),
          ),
        ],
      ),
    );
  }
}
