using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafetinSena.Application.DTOs.DtoPedido
{
    public class CrearDetallePedidoDto
    {
        public int ProductoId { get; set; }
        public int Cantidad { get; set; }
    }
}
