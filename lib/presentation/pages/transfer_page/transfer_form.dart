import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:numpad_layout/widgets/numpad.dart';

import '../../../common/values/app_colors.dart';
import '../../../common/values/app_layout.dart';
import '../../../common/values/app_styles.dart';
import '../../../logic/app/bloc/app_bloc.dart';
import '../../../logic/bottom_navigation/bottom_navigation_cubit.dart';
import '../../../logic/bottom_navigation/constants/bottom_nav_bar_items.dart';
import '../../../models/credit_card.dart';
import '../../../repository/firestore_repository.dart';
import '../../widgets/app_button.dart';

class TransferForm extends StatelessWidget {
  const TransferForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: AppLayout.getHeight(15),
      ),
      child: Column(
        children: [
          const _TransferAppBar(),
          const Gap(5),
          const _RecieverPhoto(
            downloadUrl:
                'https://firebasestorage.googleapis.com/v0/b/bank-c4ce9.appspot.com/o/user_photos%2FiOsdGCc3D1Nz81LhReUijscDCIc2?alt=media&token=469c5983-ac75-4016-a87b-0b0b32a9b29f',
          ),
          const Gap(5),
          const _RecieverUsername(username: 'Ivan Lieskov'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const _SenderCardMenu(),
              _RecieverCardMenu(
                cardsFuture: context
                    .read<FirestoreRepository>()
                    .getAllCardsList(context.read<AppBloc>().state.user.id),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          const _NumPadView(),
          const _SendMoneyButton(),
        ],
      ),
    );
  }
}

class _TransferAppBar extends StatelessWidget {
  const _TransferAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            BlocProvider.of<BottomNavigationCubit>(context)
                .getNavBarItem(BottomNavbarItem.home);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        Text(
          'Send Money',
          style: AppStyles.textStyle.copyWith(
            color: AppColors.black,
          ),
        ),
        const SizedBox(
          height: 24,
          width: 24,
        ),
      ],
    );
  }
}

class _RecieverPhoto extends StatelessWidget {
  const _RecieverPhoto({this.downloadUrl});

  final String? downloadUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: downloadUrl == null
              ? const AssetImage(
                  'assets/images/users/default_user.png',
                ) as ImageProvider
              : NetworkImage(downloadUrl!),
        ),
        border: downloadUrl != null
            ? Border.all(
                color: Colors.purple,
                width: 5,
              )
            : null,
      ),
    );
  }
}

class _RecieverUsername extends StatelessWidget {
  const _RecieverUsername({
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: AppStyles.textStyle.copyWith(color: AppColors.darkGrey),
    );
  }
}

class _SenderCardMenu extends StatefulWidget {
  const _SenderCardMenu();
  @override
  State<_SenderCardMenu> createState() => __SenderCardMenuState();
}

class __SenderCardMenuState extends State<_SenderCardMenu> {
  String? selectedCardId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 160,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton<String>(
            value: selectedCardId,
            hint: Text(
              'From',
              style: AppStyles.titleStyle.copyWith(
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
            icon: const Icon(Icons.arrow_drop_down),
            underline: Container(),
            onChanged: (selectedCard) {
              print('Selected Sender Card: $selectedCard');
              setState(() {
                selectedCardId = selectedCard;
              });
            },
            items: context
                .read<AppBloc>()
                .state
                .user
                .cards
                .map<DropdownMenuItem<String>>((card) {
              return DropdownMenuItem<String>(
                value: card.cardId,
                child: Text(
                  '${card.type.toStringValue()} ${card.cardId}',
                  style: AppStyles.titleStyle.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _RecieverCardMenu extends StatefulWidget {
  const _RecieverCardMenu({required this.cardsFuture});

  final Future<List<CreditCard>> cardsFuture;

  @override
  State<_RecieverCardMenu> createState() => _RecieverCardMenuState();
}

class _RecieverCardMenuState extends State<_RecieverCardMenu> {
  String? selectedCardId;

  @override
  Widget build(BuildContext context) {
    //TODO: Fix loading indicator, when changing pages
    return FutureBuilder<List<CreditCard>>(
      future: widget.cardsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: AppColors.red,
          );
        } else if (snapshot.hasError) {
          // If there's an error while fetching data, you can show an error message
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If no data is available, you can show an empty state
          return const Text('No cards available');
        } else {
          // If data is available, build the dropdown menu
          return Container(
            height: 40,
            width: 160,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: selectedCardId,
                  hint: Text(
                    'To',
                    style: AppStyles.titleStyle.copyWith(
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  underline: Container(),
                  onChanged: (selectedCard) {
                    print('Selected Reciever Card: $selectedCard');
                    setState(() {
                      selectedCardId = selectedCard;
                    });
                  },
                  items: snapshot.data!.map<DropdownMenuItem<String>>((card) {
                    return DropdownMenuItem<String>(
                      value: card.cardId,
                      child: Text(
                        '${card.type.toStringValue()} ${card.cardId}',
                        style: AppStyles.titleStyle.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class _NumPadView extends StatefulWidget {
  const _NumPadView();

  @override
  State<_NumPadView> createState() => _NumPadViewState();
}

class _NumPadViewState extends State<_NumPadView> {
  String number = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppLayout.getWidth(30),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const Gap(10),
          Container(
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.darkGrey,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                '\$$number',
                maxLines: 1,
                style: AppStyles.logoStyle.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          const Gap(5),
          Text(
            '2% commision. Total ammount: \$$number',
            maxLines: 1,
            style: AppStyles.textStyle.copyWith(
              color: AppColors.darkGrey,
              fontSize: 12,
            ),
          ),
          const Gap(15),
          NumPad(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            onType: (value) {
              if (number.isEmpty && value == '0') {
                return;
              }
              if (number.length >= 10) {
                return;
              }
              number += value;
              setState(() {});
            },
            runSpace: 30,
            numberStyle: AppStyles.titleStyle.copyWith(
              color: AppColors.black,
              fontSize: 30,
            ),
            rightWidget: IconButton(
              icon: const Icon(
                Icons.backspace,
                size: 25,
              ),
              onPressed: () {
                if (number.isNotEmpty) {
                  number = number.substring(0, number.length - 1);
                  setState(() {});
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SendMoneyButton extends StatelessWidget {
  const _SendMoneyButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: AppButton(
          text: 'Send Money',
          callback: () {},
          backGroundColor: AppColors.black,
          textColor: AppColors.white,
        ),
      ),
    );
  }
}
