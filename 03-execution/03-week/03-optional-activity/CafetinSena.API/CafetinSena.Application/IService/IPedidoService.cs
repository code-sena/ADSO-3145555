using CafetinSena.Application.DTOs.DtoPedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafetinSena.Application.IService
{
     public interface IPedidoService
    {
        Task CrearPedido (CrearPedidoDto dto);
       
    }
}
