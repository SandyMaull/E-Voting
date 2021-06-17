<?php

namespace App\Exports;

use App\Kandidat;
use App\Tervote;
use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Events\AfterSheet;

class SuaraExport implements FromArray, WithHeadings, ShouldAutoSize, WithEvents
{
    
    /**
    * @return \Illuminate\Support\Collection
    */
    public function array(): array
    {
        $datakandidatall = Kandidat::all();
        $datasuaraall = Tervote::all();
        foreach ($datakandidatall as $kand) {
            $datasuara = $datasuaraall->where('voting_dpm', $kand->id)->count();
            $data[$kand->id]['nama'] =  $kand->nama;
            $data[$kand->id]['suara'] =  $datasuara;
        }
        return $data;
    }
    public function headings(): array
    {
        return ["Nama", "Total Suara"];
    }

    public function registerEvents(): array
    {
        return [
            AfterSheet::class => function(AfterSheet $event) {
                $cellRange = 'A1:B1'; // All headers
                $event->sheet->getDelegate()->getStyle($cellRange)->getFont()->setSize(14);
            },
        ];
    }
}
