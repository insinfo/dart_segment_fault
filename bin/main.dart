import 'dart:convert';
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi;
import 'dart:io';
import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_production/angel3_production.dart' as production;
import 'package:angel3_cors/angel3_cors.dart';
import 'package:ffi/ffi.dart';
import 'package:file/file.dart' as file;
import 'package:angel3_static/angel3_static.dart' as static_file_server;
import 'dart:async';
import 'package:file/local.dart';

// import 'package:shelf_router/shelf_router.dart';
// import 'package:shelf/shelf.dart';
// import 'package:shelf/shelf_io.dart' as io;

//sudo apt-get install unzip
//sudo apt-get install build-essential
//https://www.youtube.com/watch?v=mpjYEobub9w&t=130s
//./wrk -t12 -c400 -d30s  http://192.168.66.123:8080
//http://localhost:8080/
// void main(List<String> args) async {
//   final server = await HttpServer.bind('0.0.0.0', 3350);
//   print('Server running on http://${server.address.host}:${server.port}');
//   server.listen((HttpRequest request) {
//     final diskinfo = statvfs("/");
//     request.response.write('available! ${diskinfo.available}');
//     request.response.close();
//   });

// var app = Router();

// app.get('/', (Request request) {
//   // final diskinfo = statvfs("/");
//   // print('main ${diskinfo}');

//   return Response.ok('asd');
// });

// final server = await io.serve(app, '0.0.0.0', 8080);
// print('Server running on ${server.address.host}:${server.port}');
//}

//to run: dart ./bin/main.dart -p 3350 -a 0.0.0.0 -j 4
//https://drive.google.com/file/d/1EGt-Yvs4OjWlPekJtHkehEZqTEDHYBOt/view?usp=sharing
main(List<String> args) async {
  return production.Runner('angel', configureServer).run(args);
}

Future configureServer(Angel app) async {
  final options = CorsOptions();
  app.fallback(cors(options));
  final fs = const LocalFileSystem();
  await app.configure(configureRoutes(fs));
}

AngelConfigurer configureRoutes(file.FileSystem fileSystem) {
  return (Angel app) {
    app.get('/', (req, res) => res.write('angel'));

    app.chain([simulatedMiddleware]).group('/api/v1', (router) {
      for (final sr in simulatedRoutes) {
        final method = sr.keys.first.toUpperCase();
        final path = sr.values.first;
        router.addRoute(method, path, (req, res) => simulatedWork);
      }
    });
   
  };
}

final simulatedRoutes = [
  {'get': '/administracao/paises'},
  {'get': '/administracao/ufs'},
  {'get': '/administracao/municipios'},
  {'get': '/administracao/modulos'},
  {'get': '/administracao/permissoes/:numCgm/:anoExercicio'},
  {'put': '/administracao/permissoes/:numCgm/:anoExercicio'},
  {'get': '/administracao/escolaridades'},
  {'get': '/administracao/tiposlogradouro'},
  {'get': '/administracao/orgaos'},
  {'get': '/administracao/unidades'},
  {'get': '/administracao/departamentos'},
  {'get': '/administracao/setores'},
  {'get': '/administracao/gestao'},
  {'get': '/administracao/usuarios'},
  {'get': '/administracao/usuarios/:numcgm'},
  {'post': '/administracao/usuarios'},
  {'put': '/administracao/usuarios'},
  {'get': '/administracao/cgm'},
  {'get': '/administracao/cgm/:cgm'},
  {'get': '/administracao/auditorias'},
  {'post': '/administracao/auditorias'},
  {'get': '/administracao/configuracao'},
  {'get': '/administracao/configuracao/by/filtro'},
  {'get': '/administracao/funcionalidades'},
  {'get': '/administracao/menu/:cgm'},
  {'get': '/administracao/organograma/hierarquia'},
  {'get': '/administracao/acoes'},
  //auth
  {'post': '/change/pass'},
  {'get': '/auth/check/permissao/:cgm'},
  {'post': '/auth/login'},
  {'post': '/auth/check'},
  {'get': '/auth/check/toke'},
  //cgm
  {'get': '/cgm/full'},
  {'get': '/cgm/full/:cgm'},
  {'delete': '/cgm'},
  {'post': '/cgm/full'},
  {'post': '/cgm/full/interno'},
  {'put': '/cgm/full'},
  {'get': '/cgm/atributos'},
  {'get': '/cgm/atributos/:cgm'},
  {'get': '/cgm/categoriashabilitacao'},
  {'get': '/cgm/tiposlogradouro'},
  //
  {'get': '/estatistica/processos/ano'},
  {'get': '/estatistica/processos/periodo/setor/primero/tramite'},
  {'get': '/estatistica/processos/situacao'},
  {'get': '/estatistica/processos/classificacao'},
  {'get': '/estatistica/processos/assunto'},
  //
  {'get': '/norma/normas'},
  //
  {'get': '/protocolo/processos/favoritos/cgm/:cgm'},
  {'post': '/protocolo/processos/favoritos'},
  {'post': '/protocolo/processos/favoritos/:codProcesso/:anoExercicio'},
  {'put': '/protocolo/processos/favoritos'},
  {'delete': '/protocolo/processos/favoritos/:id'},
  {'delete': '/protocolo/processos/favoritos/:codProcesso/:anoExercicio'},
  {'get': '/protocolo/acoes/favoritas/cgm/:cgm'},
  {'post': '/protocolo/acoes/favoritas'},
  {'post': '/protocolo/acoes/favoritas/:codAcao'},
  {'put': '/protocolo/acoes/favoritas'},
  {'delete': '/protocolo/acoes/favoritas/:id'},
  {'delete': '/protocolo/acoes/favoritas/:codAcao'},
  {'get': '/protocolo/assuntos'},
  {'post': '/protocolo/assuntos'},
  {'put': '/protocolo/assuntos'},
  {'delete': '/protocolo/assuntos'},
  {'get': '/protocolo/assuntos/:codAssunto/:codClassificacao'},
  {'get': '/protocolo/classificacoes'},
  {'post': '/protocolo/classificacoes'},
  {'put': '/protocolo/classificacoes'},
  {'delete': '/protocolo/classificacoes'},
  {'get': '/protocolo/despachospadrao'},
  {'post': '/protocolo/despachospadrao'},
  {'put': '/protocolo/despachospadrao'},
  {'delete': '/protocolo/despachospadrao'},
  {'get': '/protocolo/tramites'},
  {'post': '/protocolo/tramites'},
  {
    'put':
        '/protocolo/tramites/:codClassiOld/:codAssuntoOld/:ordemOld/:exercicioOld'
  },
  {'delete': '/protocolo/tramites'},
  {'get': '/protocolo/processos/:anoExercicio/:codProcesso'},
  {'get': '/protocolo/processos/em/apenso/:anoExercicio/:codProcesso'},
  {'get': '/protocolo/processos/apenso/a/:anoExercicio/:codProcesso'},
  {'get': '/protocolo/processos/andamentos/:anoExercicio/:codProcesso'},
  {
    'get':
        '/protocolo/processos/despachos/:anoExercicio/:codProcesso/:codAndamento/:codUsuario/:timestamp'
  },
  {'get': '/protocolo/processos'},
  {'get': '/protocolo/processos/areceber'},
  {'get': '/protocolo/processos/aemcaminhar'},
  {'get': '/protocolo/processos/byfiltros'},
  {'get': '/protocolo/processos/aapensara'},
  {'get': '/protocolo/processos/adesapensar'},
  {'get': '/protocolo/processos/adespachar'},
  {'get': '/protocolo/processos/aalterar'},
  {'get': '/protocolo/processos/acancelar'},
  {'get': '/protocolo/processos/aarquivar'},
  {'get': '/protocolo/processos/adesarquivar'},
  {'post': '/protocolo/processos'},
  {'post': '/protocolo/processos/implantar'},
  {'put': '/protocolo/processos'},
  {'post': '/protocolo/processos/receber/lote'},
  {'post': '/protocolo/processos/despachar/lote'},
  {'post': '/protocolo/processos/encaminhar/lote'},
  {'post': '/protocolo/processos/cancelarencaminhamento/lote'},
  {'post': '/protocolo/processos/apensar/lote'},
  {'post': '/protocolo/processos/desapensar/lote'},
  {'post': '/protocolo/processos/arquivar/lote'},
  {'post': '/protocolo/processos/desarquivar/lote'},
  {'post': '/protocolo/processos/anexos'},
  {'get': '/protocolo/processos/anexos/:codProcesso/:anoExercicio'},
  {'get': '/protocolo/situacoes'},
  {'get': '/protocolo/historicoarquivamento'},
  {'post': '/protocolo/historicoarquivamento'},
  {'put': '/protocolo/historicoarquivamento'},
  {'delete': '/protocolo/historicoarquivamento'},
  {'get': '/protocolo/listagemprocessos'},
  {'post': '/protocolo/listagemprocessos'},
  {'get': '/protocolo/documentos'},
  {'post': '/protocolo/documentos'},
  {'put': '/protocolo/documentos'},
  {'delete': '/protocolo/documentos'},
  {'get': '/protocolo/atributosprotocolo'},
  {'post': '/protocolo/atributosprotocolo'},
  {'put': '/protocolo/atributosprotocolo'},
  {'delete': '/protocolo/atributosprotocolo'},
  {'get': '/protocolo/processos/public/site/:anoExercicio/:codProcesso'},
];

Future<dynamic> simulatedWork(RequestContext req, ResponseContext res) async {
  try {
    // ignore: unused_local_variable
    final filters = req.queryParameters;
    final listItems = List.generate(150, (int index) => {'name': 'Jon_$index'});
    res.statusCode = 200;
    res.headers['Content-Type'] = 'application/json;charset=utf-8';
    res.headers['total-records'] = '150';
    res.write(jsonEncode(listItems));
  } catch (e, s) {
    print('simulatedWork@all $e $s');
    var v = jsonEncode({
      'is_error': true,
      'status_code': 400,
      'message': 'Error',
      'exception': e.toString(),
      'stackTrace': s.toString()
    });
    res.statusCode = 400;
    res.headers['Content-Type'] = 'application/json;charset=utf-8';
    res.write(v);
  }
}

Future<bool> simulatedMiddleware(
    RequestContext req, ResponseContext res) async {
  try {
    //print('call simulatedMiddleware');
    return true;
  } catch (e, s) {
    print('simulatedMiddleware: $s $s');
    throw AngelHttpException.notAuthenticated(message: '$e $s');
  }
}

class DiskInfo {
  int total;
  int available;
  int used;
  double usedPercentage;

  DiskInfo(this.total, this.available, this.used, this.usedPercentage);

  @override
  String toString() {
    return 'DiskInfo(total:$total,available:$available, used:$used, usedPercentage:$usedPercentage)';
  }
}

final _dylib =ffi. DynamicLibrary.open('/lib/x86_64-linux-gnu/libc.so.6');

final int Function(ffi.Pointer<ffi.Uint8>, ffi.Pointer<_statvfsStruct>)
    _posix_statvfs = _dylib
        .lookup<
            ffi.NativeFunction<
                ffi.Int32 Function(ffi.Pointer<ffi.Uint8>,
                    ffi.Pointer<_statvfsStruct>)>>('statvfs')
        .asFunction();

DiskInfo statvfs(String path) {
  if (!Platform.isLinux) {
    return DiskInfo(0, 0, 0, 0);
  }

  final buffer = ffi.malloc<_statvfsStruct>();
  final pathPointer = _toNativeUtf8(path, allocator: ffi.malloc);
  _posix_statvfs(pathPointer, buffer);

  var total = (buffer.ref.f_blocks * buffer.ref.f_frsize); // / GB;
  var disponivel = (buffer.ref.f_bfree * buffer.ref.f_frsize); // / GB;
  var used = total - disponivel;
  var usedPercentage = (used / total) * 100;

  final diskInfo = DiskInfo(total, disponivel, used, usedPercentage);
  malloc.free(pathPointer);
  malloc.free(buffer);
  return diskInfo;
}

class _statvfsStruct extends ffi.Struct {
  /// unsigned long int file system block size
  @ffi.UnsignedLong()
  external int f_bsize;

  /// unsigned long int fragment size
  @ffi.UnsignedLong()
  external int f_frsize;

  /// ulong_t | size of fs in f_frsize units
  @ffi.UnsignedLong()
  external int f_blocks;

  /// ulong_t | free blocks
  @ffi.UnsignedLong()
  external int f_bfree;

  /// ulong_t | free blocks for unprivileged users
  @ffi.UnsignedLong()
  external int f_bavail;

  /// ulong_t | inodes
  @ffi.UnsignedLong()
  external int f_files;

  /// ulong_t | free inodes
  @ffi.UnsignedLong()
  external int f_ffree;

  /// ulong_t | free inodes for unprivileged users
  @ffi.UnsignedLong()
  external int f_favail;

  /// unsigned long | file system ID
  @ffi.UnsignedLong()
  external int f_fsid;

  /// unsigned long int | mount flags
  @ffi.UnsignedLong()
  external int f_flag;

  /// unsigned long int | maximum filename length
  @ffi.UnsignedLong()
  external int f_namemax;

  //unsigned int f_spare[6];
  @ffi.Array(6)
  external ffi.Array<ffi.Uint32> f_spare;
}

ffi.Pointer<ffi.Uint8> _toNativeUtf8(String val, {ffi.Allocator allocator = malloc}) {
  final units = utf8.encode(val);
  final ffi.Pointer<ffi.Uint8> result = allocator<ffi.Uint8>(units.length + 1);
  final nativeString = result.asTypedList(units.length + 1);
  nativeString.setAll(0, units);
  nativeString[units.length] = 0;
  return result.cast();
}
