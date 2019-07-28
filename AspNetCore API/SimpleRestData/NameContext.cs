using System;
using Microsoft.EntityFrameworkCore;

namespace SimpleRestData
{
    public class NameContext : DbContext
    {
        public NameContext(DbContextOptions<NameContext> options) : base(options)
        {
        }

        public DbSet<Name> Names { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<Name>().ToTable("Names");
        }
    }
}
