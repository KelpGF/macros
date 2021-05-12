const alimentos_consumidos = {
    "Banana": 150,
    "Melão": 80,
    "Mandioca cozida" : 200
};

const macros_ingeridos = {
    carboidrado: 0,
    proteina: 0,
    gordura: 0,
}

let verificar = 0;

let qtd_calorias_totais = 0;

$.each(alimentos_consumidos, function (nome, gramas) {
    if (Object.keys(alimentos_consumidos).length) {
        if (++verificar == 1) {
            $("#table_alimentos_proporcao").html("");
            $("#table_alimentos_ingeridos_dados").html("");
        }

        const dados_alimento = dados_alimentos[nome.toLowerCase()];

        let percentual = gramas;
            percentual /= dados_alimento.porcao;

        macros_ingeridos.carboidrado += percentual * dados_alimento.carboidrado
        macros_ingeridos.proteina += percentual * dados_alimento.proteina
        macros_ingeridos.gordura += percentual * dados_alimento.gordura

        $("#table_alimentos_proporcao").append(`
            <tr>
                <th>${nome}</th>
                <td>${formatarValor(gramas)}</td>
                <td>${formatarValor(percentual * dados_alimento.carboidrado)}</td>
                <td>${formatarValor(percentual * dados_alimento.proteina)}</td>
                <td>${formatarValor(percentual * dados_alimento.gordura)}</td>
            </tr>
        `);
        
        $("#table_alimentos_ingeridos_dados").append(`
            <tr>
                <th>${nome}</th>
                <td>${formatarValor(dados_alimento.porcao)}</td>
                <td>${formatarValor(dados_alimento.carboidrado)}</td>
                <td>${formatarValor(dados_alimento.proteina)}</td>
                <td>${formatarValor(dados_alimento.gordura)}</td>
            </tr>
        `);
    }
});

$("#table_alimentos_proporcao").append(`
    <tr>
        <th colspan="3">Total de Caboidratos Ingeridos: </th>
        <td colspan="3">
            ${formatarValor(macros_ingeridos.carboidrado)} Caboidratos <span id="span_carbo"></span>
        </td>
    </tr>
    <tr>
        <th colspan="3">Total de Proteínas Ingeridas: </th>
        <td colspan="3">
            ${formatarValor(macros_ingeridos.proteina)} Proteínas <span id="span_prot"></span>
        </td>
    </tr>
    <tr>
        <th colspan="3">Total de Gorduras Ingeridas: </th>
        <td colspan="3">
            ${formatarValor(macros_ingeridos.gordura)} Gorduras <span id="span_gord"></span> 
        </td>
    </tr>
`);