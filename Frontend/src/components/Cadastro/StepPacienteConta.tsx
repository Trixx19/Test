import { Upload } from 'lucide-react';

interface Props {
  data: any;
  onChange: (data: any) => void;
}

export function StepPacienteConta({ data, onChange }: Props) {
  const inputClass = "w-full bg-[#D9D9D9] bg-opacity-60 border-none rounded-full px-5 py-3 text-gray-700 placeholder-gray-500 focus:ring-2 focus:ring-yellow-400 outline-none";
  const labelClass = "block text-sm mb-1 ml-4 text-gray-600";

  return (
    <div className="w-full max-w-4xl mx-auto animate-fadeIn">
      <h3 className="text-2xl font-bold text-center mb-6">Para Finalizar seu cadastro...</h3>

      <div className="flex flex-col items-center mb-8">
        <span className="mb-2 text-gray-600">Imagem</span>
        <label className="w-64 h-12 bg-[#D9D9D9] bg-opacity-60 rounded-full flex items-center justify-center cursor-pointer hover:bg-gray-300 transition-colors">
          <Upload size={20} className="text-gray-500 mr-2" />
          <span className="text-gray-500 text-sm">Adicione sua imagem jpg/png</span>
          <input type="file" className="hidden" accept="image/*" />
        </label>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-12 gap-6">

        <div className="md:col-span-6">
          <label className={labelClass}>Email*</label>
          <input 
            type="email" 
            placeholder="seuemail@email.com.br" 
            className={inputClass}
            value={data.email}
            onChange={e => onChange({ email: e.target.value })}
          />
        </div>
        <div className="md:col-span-6"></div>

        <div className="md:col-span-4">
          <label className={labelClass}>Senha</label>
          <input 
            type="password" 
            placeholder="Minhasenha25" 
            className={inputClass}
            value={data.senha}
            onChange={e => onChange({ senha: e.target.value })}
          />
        </div>

        <div className="md:col-span-4">
          <label className={labelClass}>Repita a Senha</label>
          <input 
            type="password" 
            placeholder="Minhasenha25" 
            className={inputClass}
            value={data.confirmarSenha}
            onChange={e => onChange({ confirmarSenha: e.target.value })}
          />
        </div>

      </div>
    </div>
  );
}