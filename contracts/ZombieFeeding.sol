//SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./ZombieFactory.sol";

/**IMPORTS */
//Con los imports, al igual que muchs lenguajes, importamos todo el contenido desde otro archivo para poder usarlo dentro del que esté importando.

/**HERENCIA EN CONTRATOS */
//Los contratos tienen un comportamiento similar a como se comportan las clases en otros lenguajes.
//En este caso usaremos un concepto llamado herencia. La herencia nos permite instanciar otro contrato
//debajo del que estamos trabajando.

//En el siguiente ejemplo estamos heredando todas las propiedades y funciones del contrato ZombieFactory
//en el siguiente contrato.
contract ZombieFeed is ZombieFactory {
    //En este contrato podremos utilizar todas las funciones y variables que contiene ZombieFactory bajo ciertas
    //circunstancias como vermos luego.

    /**UTILIZANDO LA INTERFAZ */
    //Primero necesitamos crear la interfaz que ya hemos hecho en la zona inferior.
    //La interfaz va a necesitar el adress del contrato donde se encuentra la función que deseamos ejecutar.

    //adress de cryptoKitties
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

    //Luego instanciamos la interfaz de la siguiente manera.
    KittieInterface kittieContract = KittieInterface(ckAddress);

    //                               ^ Como podemos observar enviamos dentro de los paréntesis la dirección
    //                               del contrato que vamos a consumir.

    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna) public {
        //Usamos require para comprobar que el owner del zombie sea el mismo que msg.sender
        require(
            msg.sender == zombieToOwner[_zombieId],
            "No eres el propietario de este zombie"
        );

        //Almacenamos el zombie
        Zombie storage myZombie = zombies[_zombieId];

        _targetDna = _targetDna % dnaModulus;

        uint256 newDna = myZombie.dna + _targetDna / 2;

        _createZombie("NoName", newDna);
    }
}

/**INTERFACES */
//Las interfaces son las que nos permiten llamar a funciones externas de nuestro contrato inteligente
//estas nos permiten ejecutar funciones de otros contratos inteligentes que se encuentren en la blockchain.

//Antes de usarlas tenemos que definirlas de la siguiente manera. usando la palabra clave interface.
/** EN EL CURSO DE CRYPTOZOMBIES USAN UNA VERSIÓN ANTIGUA DE SOLIDITY POR LO QUE ME HE TENIDO
 *  QUE PONER A INVESTIGAR ESTO POR MI CUENTA. PARA QUE SEA COMPATIBLE CON VERSIONES SUPERIORES A LA 0.6 DE SOLIDITY.
 */

interface KittieInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}
