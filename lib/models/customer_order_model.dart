import 'package:flutter/material.dart';

class CustomerOrderModel extends StatelessWidget {
  final dynamic order;
  const CustomerOrderModel({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.lightBlue),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ExpansionTile(
          title: Container(
            constraints: const BoxConstraints(maxHeight: 80),
            width: double.infinity,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 80,
                      maxWidth: 80,
                    ),
                    child: Image.network(order['orderimage']),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order['ordername'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ('\$') + (order['orderprice'].toStringAsFixed(2)),
                            ),
                            Text('x${order['orderqty'].toString()}'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('See more ...'),
              Text(order['deliverystatus']),
            ],
          ),
          children: [
            Container(
              // height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: order['deliverystatus'] == 'delivered'
                    ? Colors.brown.withOpacity(0.2)
                    : Colors.lightBlue.withOpacity(0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ('Name: ') + (order['custname']),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      ('Phone No.: ') + (order['phone']),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      ('Email Address: ') + (order['email']),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      ('Address: ') + (order['address']),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Payment Status: ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          order['paymentstatus'],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Delivery status: ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          order['deliverystatus'],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    order['deliverystatus'] == 'shipping'
                        ? Text(
                            ('Estimated Deivery Date: ') +
                                (order['deliverydate']),
                            style: const TextStyle(fontSize: 15),
                          )
                        : const Text(''),
                    order['deliverystatus'] == 'delivered' &&
                            order['orderreview'] == false
                        ? TextButton(
                            onPressed: () {},
                            child: const Text('Write Review'),
                          )
                        : const Text(''),
                    order['deliverystatus'] == 'delivered' &&
                            order['orderreview'] == false
                        ? Row(
                            children: const [
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                              Text(
                                'Review Added',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          )
                        : const Text(''),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
