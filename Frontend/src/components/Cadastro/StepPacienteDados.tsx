interface Props {
  data: any;
  onChange: (data: any) => void;
}

export function StepPacienteDados({ data, onChange }: Props) {
  const inputClass = "w-full bg-[#D9D9D9] bg-opacity-60 border-none rounded-full px-5 py-3 text-gray-700 placeholder-gray-500 focus:ring-2 focus:ring-yellow-400 outline-none";
  const labelClass = "block text-sm mb-1 ml-4 text-gray-600";

  return (
    <div className="w-full max-w-4xl mx-auto animate-fadeIn">
      <h3 className="text-2xl font-bold text-center mb-8">Quem é você?</h3>

      <div className="grid grid-cols-1 md:grid-cols-12 gap-6">

        <div className="md:col-span-5">
          <label className={labelClass}>Nome Completo*</label>
          <input 
            type="text" 
            placeholder="Seu nome completo aqui" 
            className={inputClass}
            value={data.nome}
            onChange={e => onChange({ nome: e.target.value })}
          />
        </div>

        <div className="md:col-span-4">
          <label className={labelClass}>CPF*</label>
          <input 
            type="text" 
            placeholder="023.456.789-00" 
            className={inputClass}
            value={data.cpf}
            onChange={e => onChange({ cpf: e.target.value })}
          />
        </div>

        <div className="md:col-span-3">
          <label className={labelClass}>Nascimento*</label>
          <input 
            type="text" 
            placeholder="02/07/1990" 
            className={inputClass}
            value={data.nascimento}
            onChange={e => onChange({ nascimento: e.target.value })}
          />
        </div>

        <div className="md:col-span-5">
          <label className={labelClass}>Como podemos te chamar?</label>
          <input 
            type="text" 
            placeholder="Apelido" 
            className={inputClass}
            value={data.apelido}
            onChange={e => onChange({ apelido: e.target.value })}
          />
        </div>

        <div className="md:col-span-3">
          <label className={labelClass}>Gênero</label>
          <input 
            type="text" 
            placeholder="M/F" 
            className={inputClass}
            value={data.genero}
            onChange={e => onChange({ genero: e.target.value })}
          />
        </div>

        <div className="md:col-span-4">
          <label className={labelClass}>CELULAR*</label>
          <input 
            type="text" 
            placeholder="(85) 98899-5566" 
            className={inputClass}
            value={data.celular}
            onChange={e => onChange({ celular: e.target.value })}
          />
        </div>

      </div>
    </div>
  );
}