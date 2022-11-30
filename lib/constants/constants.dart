import 'package:flutter/material.dart';

String email_RegExp =
    "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:/.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*.[a-zA-Z0-9]";
//const BASE_URL = "apnn.com.pk";
//const ImageUrl = "https://apnn.com.pk/TSpanel/public/images/user/";
//const API_BASE_URL = "https://apnn.com.pk/TSpanel/public/api/";
/*const BASE_URL = "urdubazar.online";
const ImageUrl = "http://urdubazar.online/fontss/public/images/user/";
const API_BASE_URL = "http://urdubazar.online/fontss/public/api/";*/
const BASE_URL = "192.168.100.158:8000";
const ImageUrl = "http://192.168.100.158:8000/images/user/";
const API_BASE_URL = "http://10.22.104.75:8000/api/";

const kSecondaryColor = Color(0xFF8B94BC);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFFC1C1C1);
const kBlackColor = Color(0xFF101010);
const kColor = Color(0xFF46A0AE);
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46A0AE), kGreenColor],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
const kPrimaryGradient1 = LinearGradient(
  colors: [Color(0xFF46A0AE), kRedColor],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
const kPrimaryGradient2 = LinearGradient(
  colors: [Color(0xFF46A0AE), kSecondaryColor],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
const kPrimaryGradient3 = LinearGradient(
  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const double kDefaultPadding = 20.0;
