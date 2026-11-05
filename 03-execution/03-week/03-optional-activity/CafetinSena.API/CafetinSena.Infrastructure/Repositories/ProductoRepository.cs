using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CafetinSena.Domain.Entities;
using CafetinSena.Domain.Interfaces;
using CafetinSena.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace CafetinSena.Infrastructure.Repositories
{
    public class ProductoRepository : IProductoRepository
    {
        private readonly CafetinDbContext _context;

        public ProductoRepository(CafetinDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Producto>> obtenerTodosLosProductos()
        {
            // Trae todos los productos de la tabla en Postgres
            return await _context.Productos.ToArrayAsync();
        }

        public async Task<Producto> obtenerPorId(int id)
        {
            return await _context.Productos.FindAsync(id);
        }

        public async Task guardarProducto(Producto producto)
        {
            await _context.Productos.AddAsync(producto);
            await _context.SaveChangesAsync(); // Aquí es donde se hace el INSERT real
        }

        public async Task eliminarProducto(int id)
        {
            var producto = await _context.Productos.FindAsync(id);
            if (producto != null)
            {
                _context.Productos.Remove(producto);
                await _context.SaveChangesAsync();
            }
        }

    }
}

