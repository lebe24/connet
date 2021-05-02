

class Data{
    final String personName,uri,listUri,state,city,source,country,squImage,gender;
    final int rank;
     var finalWealth,preWealth;
    final List<String> industries,bios,about;
    final List<dynamic> finalasset;

    Data.fromJson(Map<String, dynamic> json)
        : personName = json['personName'],uri=json['uri'],listUri =json['listUri'], rank =json['rank'], finalWealth = json['finalWorth'], state = json['state'],country = json['country'],
          city = json['city'], source = json['source'], gender = json['gender'], preWealth = json['estWorthPrev'], squImage = json['squareImage'] == null ? '' :json['squareImage'],
          industries =json['industries'] == null ? [''] : json['industries'].cast<String>(),
          bios = json['bios'] == null ? null: json['bios'].cast<String>(),
          about = json['abouts'] == null ? null: json['abouts'].cast<String>(),
          finalasset =  json['financialAssets'] == null ?null: json['financialAssets'].map((json) => json != null ? Asset.fromJson(json) : null).toList();

}

class Asset {
    Asset.fromJson(Map<String,dynamic> json)
        : exchange = json['exchange'],compName  = json['companyName'],currency = json['currency'],
          noShare = json['numberOfShare'],sharePrice = json['sharePrice'].toString(), ticker = json['ticker'];

    final String exchange,compName,currency,noShare,ticker, sharePrice;
}