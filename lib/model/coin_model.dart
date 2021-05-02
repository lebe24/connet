class Coin{
  final String symbol,name,image,id;
  final int marketCapRank;
  var currentPrice,marketCap,high24,low24,percentChange;

  Coin.fromJson(Map<String, dynamic> json)
      :id = json['id'],symbol = json['symbol'],name =json['name'],image = json['image'],
      marketCapRank = json['market_cap_rank'],
      currentPrice = json['current_price'],marketCap = json['market_cap'],high24 = json['high_24h'] ,low24 =json['low_24h'],percentChange = json['price_change_percentage_24h'];
}