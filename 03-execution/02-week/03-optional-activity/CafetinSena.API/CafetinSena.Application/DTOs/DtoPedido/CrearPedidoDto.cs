using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafetinSena.Application.DTOs.DtoPedido
{
    public class CrearPedidoDto
    {
        public string Cliente { get; set; }
        public List<CrearDetallePedidoDto> Detalles { get; set; } = new();
    }
}
