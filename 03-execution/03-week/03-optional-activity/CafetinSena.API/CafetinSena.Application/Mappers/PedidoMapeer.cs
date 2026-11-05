using CafetinSena.Application.DTOs.DtoPedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafetinSena.Application.Mappers
{
    public class PedidoMapeer
    {
        public static Pedido ToEntity(CrearPedidoDto dto)
        {
            return new Pedido
            {
                Cliente = dto.Cliente,
                Detalles = dto.Detalles.Select(d => new DetallePedido
                {

                    ProductoId = d.ProductoId,
                    Cantidad = d.Cantidad
                }
                ).ToList()
            };
        }
    }
}
