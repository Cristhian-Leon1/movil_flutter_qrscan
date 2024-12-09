class DosAdultos {
  String? id;
  String? nombre;
  String? qrCode;
  bool almuerzo1;
  bool cerveza1;
  bool cerveza2;
  bool helado1;
  bool empanada1;
  bool postre1;
  bool almuerzo2;
  bool cerveza3;
  bool cerveza4;
  bool helado2;
  bool empanada2;
  bool postre2;
  int? version;

  DosAdultos({
    this.id,
    this.nombre,
    this.qrCode,
    this.almuerzo1 = true,
    this.cerveza1 = true,
    this.cerveza2 = true,
    this.helado1 = true,
    this.empanada1 = true,
    this.postre1 = true,
    this.almuerzo2 = true,
    this.cerveza3 = true,
    this.cerveza4 = true,
    this.helado2 = true,
    this.empanada2 = true,
    this.postre2 = true,
    this.version,
  });

  factory DosAdultos.fromJson(Map<String, dynamic> json) {
    return DosAdultos(
      id: json['_id'],
      nombre: json['nombre'],
      qrCode: json['qrCode'],
      almuerzo1: json['almuerzo1'] ?? true,
      cerveza1: json['cerveza1'] ?? true,
      cerveza2: json['cerveza2'] ?? true,
      helado1: json['helado1'] ?? true,
      empanada1: json['empanada1'] ?? true,
      postre1: json['postre1'] ?? true,
      almuerzo2: json['almuerzo2'] ?? true,
      cerveza3: json['cerveza3'] ?? true,
      cerveza4: json['cerveza4'] ?? true,
      helado2: json['helado2'] ?? true,
      empanada2: json['empanada2'] ?? true,
      postre2: json['postre2'] ?? true,
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombre': nombre,
      'qrCode': qrCode,
      'almuerzo1': almuerzo1,
      'cerveza1': cerveza1,
      'cerveza2': cerveza2,
      'helado1': helado1,
      'empanada1': empanada1,
      'postre1': postre1,
      'almuerzo2': almuerzo2,
      'cerveza3': cerveza3,
      'cerveza4': cerveza4,
      'helado2': helado2,
      'empanada2': empanada2,
      'postre2': postre2,
      '__v': version,
    };
  }
}

class AdultoYnino {
  String? id;
  String? nombre;
  String? qrCode;
  bool almuerzo1;
  bool cerveza1;
  bool cerveza2;
  bool helado1;
  bool empanada1;
  bool postre1;
  bool perroOhamburguesa;
  bool gaseosa1;
  bool helado2;
  bool empanada2;
  bool postre2;
  int? version;

  AdultoYnino({
    this.id,
    this.nombre,
    this.qrCode,
    this.almuerzo1 = true,
    this.cerveza1 = true,
    this.cerveza2 = true,
    this.helado1 = true,
    this.empanada1 = true,
    this.postre1 = true,
    this.perroOhamburguesa = true,
    this.gaseosa1 = true,
    this.helado2 = true,
    this.empanada2 = true,
    this.postre2 = true,
    this.version,
  });

  factory AdultoYnino.fromJson(Map<String, dynamic> json) {
    return AdultoYnino(
      id: json['_id'],
      nombre: json['nombre'],
      qrCode: json['qrCode'],
      almuerzo1: json['almuerzo1'] ?? true,
      cerveza1: json['cerveza1'] ?? true,
      cerveza2: json['cerveza2'] ?? true,
      helado1: json['helado1'] ?? true,
      empanada1: json['empanada1'] ?? true,
      postre1: json['postre1'] ?? true,
      perroOhamburguesa: json['perroOhamburguesa'] ?? true,
      gaseosa1: json['gaseosa1'] ?? true,
      helado2: json['helado2'] ?? true,
      empanada2: json['empanada2'] ?? true,
      postre2: json['postre2'] ?? true,
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombre': nombre,
      'qrCode': qrCode,
      'almuerzo1': almuerzo1,
      'cerveza1': cerveza1,
      'cerveza2': cerveza2,
      'helado1': helado1,
      'empanada1': empanada1,
      'postre1': postre1,
      'perroOhamburguesa': perroOhamburguesa,
      'gaseosa1': gaseosa1,
      'helado2': helado2,
      'empanada2': empanada2,
      'postre2': postre2,
      '__v': version,
    };
  }
}
