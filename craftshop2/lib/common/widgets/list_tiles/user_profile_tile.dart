import 'package:flutter/cupertino.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TCirularImage(image: TImage.user, width: 50, height: 50, padding: 0,),
      title: Text('Coding with me' , style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColor.white)),
      subtitle: Text('support@codingwithMe.com' , style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColor.white)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit,color: Tcolor.white)),
    );
  }
}