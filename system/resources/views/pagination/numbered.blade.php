<!-- resources/views/pagination/numbered.blade.php -->
<ul class="pagination">
    @foreach ($elements as $element)
        @if (is_string($element))
            <li class="page-item disabled" aria-disabled="true">
                <span class="page-link">{{ $element }}</span>
            </li>
        @endif

        @if (is_array($element))
            @foreach ($element as $page => $url)
                @if ($page == $paginator->currentPage())
                    <li class="page-item active" aria-current="page">
                        <span class="page-link">{{ $page }}</span>
                    </li>
                @else
                    <li class="page-item">
                        <a href="{{ $url }}" class="page-link">{{ $page }}</a>
                    </li>
                @endif
            @endforeach
        @endif
    @endforeach
</ul>
