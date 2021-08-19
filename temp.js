var details = {};

if(metadata.temperature < 10) { // Adiciona um 0 à esquerda
    if(metadata.temperature < 0) {

    var temp = metadata.temperature.split('-')[1];
    details.temperature = '-0' + temp + ' ºC';
        
    } else {
            details.temperature = '0' + metadata.temperature + ' ºC';
    }
} else {
    details.temperature = metadata.temperature + ' ºC';
}

details.alarmTime = metadata.alarmTime;
details.temperatureType = metadata.temperatureType;

// Se exitir uma temperatura anterior
if (metadata.prevAlarmDetails) {
    var prevDetails = JSON.parse(metadata.prevAlarmDetails);
    details.count = prevDetails.count + 1;
    // pega a temperatura anterior
    details.prevTemperature = prevDetails.temperature;
    details.updatedMenor = false;
    
    var horaEnvioAnterior = new Date(prevDetails.horaDoEmailEnviado);
    var horaAtual = new Date(metadata.alarmTime);
    
    horaEnvioAnterior = horaEnvioAnterior.setMinutes(horaEnvioAnterior.getMinutes() + 15);
    horaEnvioAnterior = new Date(horaEnvioAnterior);
    
    if( horaAtual > horaEnvioAnterior ) { // Se passou se o tempo definido
        details.expiredTimeOut = true;
        details.horaDoEmailEnviado = new Date(metadata.alarmTime);
    } else {
        details.expiredTimeOut = false;
        details.horaDoEmailEnviado = prevDetails.horaDoEmailEnviado;
    }

    // Se a nova temperatura é maior que a anterior o updatedMenor = true
    // e atualiza a temperatura menor.
    if(metadata.temperature > prevDetails.menor) {
        details.updatedMenor = true;
        details.menor = metadata.temperature;
    
    } else {
        // se a atual não for menor, apenas atualiza a menor com menor anterior
        details.menor = prevDetails.menor;
    }
    
} else {
    // Se não existe uma temperatura, a menor será a atual
    details.horaDoEmailEnviado = new Date(metadata.alarmTime);
    details.menor = metadata.temperature;
    details.count = 1;
}

if(details.count > '3') {
    details.count = 1;
}

return details;