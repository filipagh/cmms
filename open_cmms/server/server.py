from http.server import HTTPServer, SimpleHTTPRequestHandler


def run(server_class=HTTPServer, handler_class=SimpleHTTPRequestHandler):

    server_address = ('0.0.0.0', 22222)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()

run()
