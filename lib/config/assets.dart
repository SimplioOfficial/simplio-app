import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset.dart';

class Assets {
  const Assets._();

  static const Asset simplio = Asset(
    name: 'Simplio',
    ticker: 'sio',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    networks: [solana],
  );

  static const Asset bitcoin = Asset(
    name: 'Bitcoin',
    ticker: 'btc',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xffff9900),
      foregroundColor: Colors.white,
    ),
  );

  static const Asset bitcoinCach = Asset(
    name: 'Bitcoin Cash',
    ticker: 'bch',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff8dc351),
      foregroundColor: Colors.white,
    ),
  );

  static const Asset solana = Asset(
    name: 'Solana',
    ticker: 'sol',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff411e7d),
      foregroundColor: Colors.white,
    ),
  );

  static const Asset flux = Asset(
    name: 'Flux',
    ticker: 'flux',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff2a60d0),
      foregroundColor: Colors.white,
    ),
  );

  static const Asset dogecoin = Asset(
    name: 'Dogecoin',
    ticker: 'doge',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xffffe4a4),
      foregroundColor: Colors.white,
    ),
  );

  static const Asset dash = Asset(
    name: 'Dash',
    ticker: 'dash',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff008be6),
      foregroundColor: Colors.white,
    ),
  );

  static const Asset digibyte = Asset(
    name: 'Digibyte',
    ticker: 'dgb',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff006ad2),
      foregroundColor: Colors.white,
    ),
  );

  static const Asset litecoin = Asset(
    name: 'Litecoin',
    ticker: 'ltc',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xffeaeaea),
      foregroundColor: Colors.white,
    ),
  );

  static const Asset ethereum = Asset(
    name: 'Ethereum',
    ticker: 'eth',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
  );

  static const Asset chainlink = Asset(
    name: 'Chainlink',
    ticker: 'chain',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset celsius = Asset(
    name: 'Celsius',
    ticker: 'CEL',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset ceekVR = Asset(
    name: 'Ceek VR',
    ticker: 'CEEK',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset bzx = Asset(
    name: 'bZx Protocol',
    ticker: 'BZRX',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset bread = Asset(
    name: 'Bread',
    ticker: 'BRD',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset braintrust = Asset(
    name: 'Braintrust',
    ticker: 'BTRST',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset bluzelle = Asset(
    name: 'Bluzelle',
    ticker: 'BLZ',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset binanceUSD = Asset(
    name: 'Binance USD',
    ticker: 'BUSD',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xfff3ba2f),
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset bellaProtocol = Asset(
    name: 'Bella Protocol',
    ticker: 'BEL',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset basicAttentionToken = Asset(
    name: 'Basic Attention Token',
    ticker: 'BAT',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset bandProtocol = Asset(
    name: 'Band Protocol',
    ticker: 'BAND',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset bancor = Asset(
    name: 'Bancor',
    ticker: 'BNT',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset badgerDAO = Asset(
    name: 'Badger DAO',
    ticker: 'BADGER',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset axisToken = Asset(
    name: 'AxisToken',
    ticker: 'AXIS',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset audius = Asset(
    name: 'Audius',
    ticker: 'AUDIO',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset anyswap = Asset(
    name: 'Anyswap',
    ticker: 'ANY',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset ankr = Asset(
    name: 'Ankr',
    ticker: 'ANKR',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset amp = Asset(
    name: 'Amp',
    ticker: 'AMP',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset alphaFinanceLab = Asset(
    name: 'Alpha Finance Lab',
    ticker: 'ALPHA',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset alitas = Asset(
    name: 'Alitas',
    ticker: 'ALT',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset alienWorlds = Asset(
    name: 'Alien Worlds',
    ticker: 'TLM',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset akropolis = Asset(
    name: 'Akropolis',
    ticker: 'AKRO',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset adventureGold = Asset(
    name: 'Adventure Gold',
    ticker: 'AGLD',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset aavegotchi = Asset(
    name: 'Aavegotchi',
    ticker: 'GHST',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset aave = Asset(
    name: 'Aave',
    ticker: 'AAVE',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset zeroX = Asset(
    name: '0x',
    ticker: 'ZRX',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset chiliz = Asset(
    name: 'Chiliz',
    ticker: 'CHZ',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset chromia = Asset(
    name: 'chromia',
    ticker: 'CHR',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset cocosBCX = Asset(
    name: 'Cocos BCX',
    ticker: 'COCOS',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset coin98 = Asset(
    name: 'Coin98',
    ticker: 'C98',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset compound = Asset(
    name: 'Compound',
    ticker: 'COMP',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset coti = Asset(
    name: 'COTI',
    ticker: 'COTI',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset cryptoDotComCoin = Asset(
    name: 'Crypto.com Coin',
    ticker: 'CRO',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset curveDAOToken = Asset(
    name: 'Curve DAO Token',
    ticker: 'CRV',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset dai = Asset(
    name: 'DAI',
    ticker: 'DAI',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset degoFinance = Asset(
    name: 'Dego Finance',
    ticker: 'DEGO',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset dexe = Asset(
    name: 'DeXe',
    ticker: 'DEXE',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset dodo = Asset(
    name: 'DODO',
    ticker: 'DODO',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset dusk = Asset(
    name: 'Dusk',
    ticker: 'DUSK',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset eRadix = Asset(
    name: 'e-Radix',
    ticker: 'EXRD',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset enjinCoin = Asset(
    name: 'Enjin Coin',
    ticker: 'ENJ',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset ethereumNameService = Asset(
    name: 'Ethereum Name Service',
    ticker: 'ENS',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset everipedia = Asset(
    name: 'Everipedia',
    ticker: 'IQ',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset feiProtocol = Asset(
    name: 'Fei Protocol',
    ticker: 'FEI',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset fetch = Asset(
    name: 'Fetch',
    ticker: 'FET',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset frontier = Asset(
    name: 'Frontier',
    ticker: 'FRONT',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset gala = Asset(
    name: 'Gala',
    ticker: 'GALA',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset gifto = Asset(
    name: 'Gifto',
    ticker: 'GTO',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset gitcoin = Asset(
    name: 'Gitcoin',
    ticker: 'GTC',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset gnosis = Asset(
    name: 'Gnosis',
    ticker: 'GNO',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset hifiFinance = Asset(
    name: 'HiFi Finance',
    ticker: 'MFT',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset holo = Asset(
    name: 'Holo',
    ticker: 'HOT',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset huobiToken = Asset(
    name: 'Huobi Token',
    ticker: 'HT',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset husd = Asset(
    name: 'HUSD',
    ticker: 'HUSD',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset hxro = Asset(
    name: 'Hxro',
    ticker: 'HXRO',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
    networks: [ethereum],
  );

  static const Asset zcash = Asset(
    name: 'Zcash',
    ticker: 'zec',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xfff5df97),
      foregroundColor: Colors.white,
    ),
  );

  static const List<Asset> supported = [
    simplio,
    bitcoin,
    bitcoinCach,
    solana,
    binanceUSD,
    dash,
    litecoin,
    flux,
    digibyte,
    ethereum,
    chainlink,
    celsius,
    ceekVR,
    bzx,
    bread,
    braintrust,
    bluzelle,
    bellaProtocol,
    basicAttentionToken,
    bandProtocol,
    bancor,
    badgerDAO,
    axisToken,
    audius,
    anyswap,
    ankr,
    amp,
    alphaFinanceLab,
    alitas,
    alienWorlds,
    akropolis,
    adventureGold,
    aavegotchi,
    aave,
    zeroX,
    chiliz,
    chromia,
    cocosBCX,
    coin98,
    compound,
    coti,
    cryptoDotComCoin,
    curveDAOToken,
    dai,
    degoFinance,
    dexe,
    dodo,
    dusk,
    eRadix,
    ethereumNameService,
    everipedia,
    feiProtocol,
    fetch,
    frontier,
    gala,
    gifto,
    gitcoin,
    gnosis,
    hifiFinance,
    holo,
    huobiToken,
    husd,
    hxro,
    enjinCoin,
    zcash,
    dogecoin,
  ];
}
