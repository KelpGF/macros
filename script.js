const dados = {
    sexo : "",
    peso : "",
    altura : "",
    idade : "",
    biotipo : "",
    gastoBasal : {
        "M" : () => { return (66 + (13.7 * dados.peso) + (5 * dados.altura) - (6.8 * dados.idade)) },
        "F" : () => { return (665 + (9.6 * dados.peso) + (1.8 * dados.altura) - (4.7 * dados.idade)) },
    },
    macros : {
        carboidratos : 0,
        proteinas : 0,
        gorduras : 0,
    },
    gastoAcademia: 0,
    gastoDiario: 0,
    gastoTotal : 0,

}
const biotipo = {
    ecto : 1.5,
    endo : 1.5,
    meso : 1,
}

$(".sucesso").hide();

$(`input`).on('keyup change', function() {
    dados.biotipo = $(`input[name="biotipo"]:checked`).val();
    dados.sexo = $(`input[name="sexo"]:checked`).val();
    dados.peso = $(`#peso`).val();
    dados.altura = $(`#altura`).val();
    dados.idade = $(`#idade`).val();
    dados.gastoDiario = $(`#gasto_diario`).val();
    dados.gastoAcademia = $(`#gasto_execicios`).val();

    if (dados.idade != "" && dados.peso != "" && dados.altura != "") {
        dados.idade = Number(dados.idade);
        dados.peso = Number(dados.peso);
        dados.altura = Number(dados.altura);

        if (dados.gastoAcademia == "" && dados.gastoDiario == "") {
            dados.gastoDiario = 350;
            dados.gastoAcademia = 350;
        }

        dados.gastoDiario = Number(dados.gastoDiario);
        dados.gastoAcademia = Number(dados.gastoAcademia);        

        dados.gastoTotal = dados.gastoBasal[dados.sexo]() + dados.gastoDiario + dados.gastoAcademia;
        $("#total").text(formatarValor(dados.gastoTotal));

        $("#consumo_base").text(formatarValor(dados.gastoTotal));
        // dados.gastoTotal *= 1.2;
        $("#consumo").text(formatarValor(dados.gastoTotal));
        
        $(".sucesso").show("fast");
        $("#basal").text(formatarValor(dados.gastoBasal[dados.sexo]()));

        const macros = dados.macros;

        macros.proteinas = dados.peso * 2;
        // macros.gorduras = biotipo[dados.biotipo] * dados.peso;
        macros.gorduras = 1 * dados.peso;

        dados.gastoTotal -= ( (macros.gorduras * 9) + (macros.proteinas * 4) )

        macros.carboidratos = dados.gastoTotal / 4;
        
        $("#table_macros").html("");
        $("#table_macros").append(`
            <tr>
                <td>Carboidratos</td>
                <td>${formatarValor(macros.carboidratos)}</td>
                <td>1g - 4 calorias</td>
            </tr>
            <tr>
                <td>Proteínas</td>
                <td>${formatarValor(macros.proteinas)}</td>
                <td>1g - 4 calorias</td>
            </tr>
            <tr>
                <td>Gorduras</td>
                <td>${formatarValor(macros.gorduras)}</td>
                <td>1g - 9 calorias</td>
            </tr>
        `);

        $("#span_carbo").text(`(restando ${formatarValor(dados.macros.carboidratos - macros_ingeridos.carboidrado)}g)`);
        $("#span_prot").text(`(restando ${formatarValor(dados.macros.proteinas - macros_ingeridos.proteina)}g)`);
        $("#span_gord").text(`(restando ${formatarValor(dados.macros.gorduras - macros_ingeridos.gordura)}g)`);
    } else {
        $(".sucesso").fadeOut("fast");
        $("#table_macros").html("");

        $("#span_carbo").text("");
        $("#span_prot").text("");
        $("#span_gord").text("");
    }
});


function formatarValor(valor)
{
    return (valor).toLocaleString('pt-BR', { currency: 'BRL' });
}