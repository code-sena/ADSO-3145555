using CafetinSena.Domain.Interfaces.IRepository;
using CafetinSena.Infrastructure.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CafetinSena.Domain.Entities;

namespace CafetinSena.Infrastructure.Repositories
{
    public class PedidoRepository : IPedidoRepository
    {
        private readonly CafetinDbContext _context;

        public PedidoRepository (CafetinDbContext context)
        {
            _context = context;
        }

        public async Task AgregarAsync(Pedido pedido)
        {
            await _context.Pedidos.AddAsync(pedido);
        }

        public async Task GuardarAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
