function initialize(workshop) {
    workshop.load_workshop();

    let k8s_host = process.env['KUBERNETES_SERVICE_HOST'];
    let k8s_port = process.env['KUBERNETES_SERVICE_PORT'];
    let k8s_url = `https://${k8s_host}:${k8s_port}`;

    workshop.data_variable('kubernetes_url', k8s_url);
}

exports.default = initialize;

module.exports = exports.default;
