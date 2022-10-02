import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
    AdditionalProperties(pubName: 'BackendAPI'),
    inputSpecFile: 'http://localhost:8000/openapi.json',
    overwriteExistingFiles: true,
    alwaysRun: true,
    generatorName: Generator.dart,
    outputDirectory: 'api/')
class Example extends OpenapiGeneratorConfig {}
