using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafetinSena.Domain.Interfaces.IRepository
{
    public interface IPedidoRepository
    {
        Task AgregarAsync(Pedido pedido);
        Task GuardarAsync();
    }
}
